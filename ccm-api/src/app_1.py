from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from marshmallow import Schema, fields, ValidationError, pre_load
from flask_cors import CORS
import base64
from base64 import b64decode

app = Flask(__name__)
CORS(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'oracle://CCMDB:CCMDB123@localhost:1521/xe'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

db = SQLAlchemy(app)
ma = Marshmallow(app)


class Utilisateur(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nom = db.Column(db.String(70), unique=True)
    prenom = db.Column(db.String(70), unique=True)
    login = db.Column(db.String(70), unique=True)
    password = db.Column(db.String(70), unique=True)
    profileid = db.Column(db.Integer, db.ForeignKey('profile.id'))
    # profile = db.relationship('Profile', backref='utilisateurs')

    def __init__(self, nom, prenom, login, password, profileid):
        self.nom = nom
        self.prenom = prenom
        self.login = login
        self.password = password
        self.profileid = profileid


privileges = db.Table('profile_privilege',
                      db.Column('privilegeid', db.Integer, db.ForeignKey(
                          'privilege.id'), primary_key=True),
                      db.Column('profileid', db.Integer, db.ForeignKey(
                          'profile.id'), primary_key=True)
                      )


class Profile(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nom = db.Column(db.String(70))
    utilisateurs = db.relationship(
        'Utilisateur', backref='profile', lazy='joined')
    privileges = db.relationship('Privilege', secondary=privileges, lazy='subquery',
                                 backref=db.backref('profiles', lazy='noload'))

    def __init__(self, nom):
        self.nom = nom


class Privilege(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(70))
    icon = db.Column(db.String(70))
    path = db.Column(db.String(70))
    active = db.Column(db.String(10))
    # children = db.relationship('Children', backref='privilege', lazy='joined')
    parentid = db.Column(db.Integer, db.ForeignKey(
        'privilege.id'))  # parent company ID
    children = db.relationship(
        'Privilege')
    form = db.relationship(
        'Form', backref='privilege', lazy='joined')

    def __init__(self, title, path, icon):
        self.title = title
        self.icon = icon
        self.path = path


# class Children(db.Model):
#     id = db.Column(db.Integer, primary_key=True)
#     title = db.Column(db.String(70), unique=True)
#     path = db.Column(db.String(70), unique=True)
#     privilegeid = db.Column(db.Integer, db.ForeignKey('privilege.id'))

#     def __init__(self, title, path, privilegeid):
#         self.title = title
#         self.path = path
#         self.privilegeid = privilegeid
class Form(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String(20))
    count = db.Column(db.String(20))
    next_button = db.Column(db.String(20))
    previous_button = db.Column(db.String(20))
    done_button = db.Column(db.String(20))
    privilegeid = db.Column(db.Integer, db.ForeignKey('privilege.id'))
    formStep = db.relationship(
        'FormStep', backref='form', lazy='joined')


class FormStep(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(20))
    formid = db.Column(db.Integer, db.ForeignKey('form.id'))
    fields = db.relationship(
        'Field', backref='formstep', lazy='joined')


class Field(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50))
    title = db.Column(db.String(50))
    placeholder = db.Column(db.String(50))
    type = db.Column(db.String(50))
    value = db.Column(db.String(50))
    fieldValues = db.relationship(
        'FieldValues', backref='field', lazy='joined')
    formstepid = db.Column(db.Integer, db.ForeignKey('form_step.id'))


class FieldValues(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    value = db.Column(db.String(50))
    src = db.Column(db.String(50))
    fieldid = db.Column(db.Integer, db.ForeignKey('field.id'))


db.create_all()


class FieldValuesSchema(ma.Schema):
    id = fields.Int(dump_only=True)
    value = fields.String()
    src = fields.String()

    class Meta:
        fields = ('id', 'value', 'src')


fieldValues_schema = FieldValuesSchema()
fieldValuesList_schema = FieldValuesSchema(many=True)


class FieldSchema(ma.Schema):
    id = fields.Int(dump_only=True)
    name = fields.String()
    title = fields.String()
    placeholder = fields.String()
    type = fields.String()
    value = fields.String()
    fieldValues = fields.Nested(fieldValuesList_schema, dump_only=True)

    class Meta:
        fields = ('id', 'name', 'title', 'placeholder',
                  'type', 'value', 'fieldValues')


field_schema = FieldSchema()
fields_schema = FieldSchema(many=True)


class FormStepSchema(ma.Schema):
    id = fields.Int(dump_only=True)
    title = fields.String()
    fields = fields.Nested(fields_schema, dump_only=True)

    class Meta:
        fields = ('id', 'title', 'fields')


formStep_schema = FormStepSchema()
formSteps_schema = FormStepSchema(many=True)


class FormSchema(ma.Schema):
    id = fields.Int(dump_only=True)
    code = fields.String()
    count = fields.String()
    next_button = fields.String()
    previous_button = fields.String()
    done_button = fields.String()
    formStep = fields.Nested(formSteps_schema, dump_only=True)


form_schema = FormSchema()
forms_schema = FormSchema(many=True)


class PrivilegeSchema(ma.Schema):
    id = fields.Int(dump_only=True)
    title = fields.String()
    icon = fields.String()
    path = fields.String()
    active = fields.String()
    form = fields.Nested(forms_schema, dump_only=True)
    children = fields.Nested('self', many=True, exclude=('children',))
    # children = fields.Nested(childrens_schema, dump_only=True)
    # class Meta:
    #     fields = ('id', 'title', 'icon', 'path')


privilege_schema = PrivilegeSchema()
privileges_schema = PrivilegeSchema(many=True)


class ProfileSchema(ma.Schema):
    id = fields.Int(dump_only=True)
    privileges = fields.Nested(privileges_schema, dump_only=True)
    nom = fields.String()

    class Meta:
        fields = ('id', 'nom', 'privileges')


profile_schema = ProfileSchema()
profiles_schema = ProfileSchema(many=True)


class UtilisateurSchema(ma.Schema):
    id = fields.Int(dump_only=True)
    nom = fields.String()
    prenom = fields.String()
    login = fields.String()
    password = fields.String()
    profile = fields.Nested(profile_schema, dump_only=True)

    class Meta:
        fields = ('id', 'nom', 'prenom', 'login', 'password', 'profile')


utilisateur_schema = UtilisateurSchema()
utilisateurs_schema = UtilisateurSchema(many=True)


##################
# Profiles
##################


@app.route('/profiles', methods=['POST'])
def create_profile():
    nom = request.json['nom']
    privileges = request.json['privileges']
    print(privileges)
    new_profile = Profile(nom)
    db.session.add(new_profile)
    db.session.commit()
    for privilege in request.json['privileges']:
        print(privilege['id'])
        pr = Privilege.query.get(privilege['id'])
        new_profile.privileges.append(pr)
        # Profile.query.filter_by(nom='Administrateur').first()
        db.session.commit()
    return profile_schema.jsonify(new_profile)


@app.route('/profiles', methods=['GET'])
def get_profiles():
    all_profiles = Profile.query.all()
    all_profiles[0].test = 'test'
    result = profiles_schema.dump(all_profiles)
    print(result)
    print(all_profiles[0].utilisateurs)
    print(utilisateurs_schema.dump(all_profiles[0].utilisateurs))
    return jsonify(result)


@app.route('/profiles/<id>', methods=['GET'])
def get_profile(id):
    profile = Profile.query.get(id)
    print(profile)
    return profile_schema.jsonify(profile)


@app.route('/profiles/<id>', methods=['PUT'])
def update_profile(id):
    profile = Profile.query.get(id)
    nom = request.json['nom']
    profile.nom = nom
    profile.privileges.clear()
    db.session.commit()
    for privilege in request.json['privileges']:
        print(privilege['id'])
        pr = Privilege.query.get(privilege['id'])
        profile.privileges.append(pr)
        # User.query.filter_by(username='peter').first()
        db.session.commit()
    return profile_schema.jsonify(profile)


@app.route('/profiles/<id>', methods=['DELETE'])
def delete_profile(id):
    profile = Profile.query.get(id)
    db.session.delete(profile)
    db.session.commit()
    return profile_schema.jsonify(profile)

##################
# Utilisateurs
##################


@app.route('/utilisateurs', methods=['POST'])
def create_utilisateur():
    nom = request.json['nom']
    prenom = request.json['prenom']
    login = request.json['login']
    password = request.json['password']
    profileid = request.json['profileid']
    new_utilisateur = Utilisateur(nom, prenom, login, password, profileid)
    db.session.add(new_utilisateur)
    db.session.commit()
    return utilisateur_schema.jsonify(new_utilisateur)


@app.route('/utilisateurs', methods=['GET'])
def get_utilisateurs():
    all_utilisateurs = Utilisateur.query.all()
    result = utilisateurs_schema.dump(all_utilisateurs)
    return jsonify(result)


@app.route('/utilisateurs/<id>', methods=['GET'])
def get_utilisateur(id):
    utilisateur = Utilisateur.query.get(id)
    return utilisateur_schema.jsonify(utilisateur)


@app.route('/utilisateurs/login', methods=['POST'])
def get_utilisateurByLoginAndPassword():
    login = request.json['login']
    password = request.json['password']
    utilisateur = Utilisateur.query.filter(
        login == login, password == password).first()
    return utilisateur_schema.jsonify(utilisateur)


@app.route('/utilisateurs/<id>', methods=['PUT'])
def update_utilisateur(id):
    utilisateur = Utilisateur.query.get(id)
    nom = request.json['nom']
    prenom = request.json['prenom']
    login = request.json['login']
    password = request.json['password']
    profileid = request.json['profileid']
    utilisateur.nom = nom
    utilisateur.prenom = prenom
    utilisateur.login = login
    utilisateur.password = password
    utilisateur.profileid = profileid
    db.session.commit()
    return utilisateur_schema.jsonify(utilisateur)


@app.route('/utilisateurs/<id>', methods=['DELETE'])
def delete_utilisateur(id):
    utilisateur = Utilisateur.query.get(id)
    db.session.delete(utilisateur)
    db.session.commit()
    return utilisateur_schema.jsonify(utilisateur)

##################
# Privileges
##################


@app.route('/privileges', methods=['POST'])
def create_privilege():
    title = request.json['title']
    icon = request.json['icon']
    path = request.json['path']
    new_privilege = Privilege(title, icon, path)
    db.session.add(new_privilege)
    db.session.commit()
    return privilege_schema.jsonify(new_privilege)


@app.route('/privileges', methods=['GET'])
def get_privileges():
    all_privileges = Privilege.query.filter(Privilege.parentid == None).all()
    result = privileges_schema.dump(all_privileges)
    return jsonify(result)


@app.route('/privileges/<id>', methods=['GET'])
def get_privilege(id):
    privilege = Privilege.query.get(id)
    print(privilege)
    return privilege_schema.jsonify(privilege)


@app.route('/privileges/<id>', methods=['PUT'])
def update_privilege(id):
    privilege = Privilege.query.get(id)
    title = request.json['title']
    icon = request.json['icon']
    path = request.json['path']
    privilege.title = title
    privilege.icon = icon
    privilege.path = path
    db.session.commit()
    return privilege_schema.jsonify(privilege)


@app.route('/privileges/<id>', methods=['DELETE'])
def delete_privilege(id):
    privilege = Privilege.query.get(id)
    db.session.delete(privilege)
    db.session.commit()
    return privilege_schema.jsonify(privilege)

##################
# Childrens
##################


@app.route('/children', methods=['POST'])
def create_children():
    title = request.json['title']
    path = request.json['path']
    privilegeid = request.json['privilegeid']
    new_children = Children(title, path, privilegeid)
    db.session.add(new_children)
    db.session.commit()
    return children_schema.jsonify(new_children)


@app.route('/children', methods=['GET'])
def get_allChildren():
    all_children = Children.query.all()
    result = children_schema.dump(all_children)
    return jsonify(result)


@app.route('/children/<id>', methods=['GET'])
def get_children(id):
    children = Children.query.get(id)
    return children_schema.jsonify(children)


@app.route('/children/<id>', methods=['PUT'])
def update_children(id):
    children = Children.query.get(id)
    title = request.json['title']
    path = request.json['path']
    privilegeid = request.json['privilegeid']
    children.title = title
    children.path = path
    children.privilegeid = privilegeid
    db.session.commit()
    return children_schema.jsonify(children)


@app.route('/children/<id>', methods=['DELETE'])
def delete_children(id):
    children = Children.query.get(id)
    db.session.delete(children)
    db.session.commit()
    return children_schema.jsonify(children)


##################
# Form
##################

@app.route('/forms/<arg>', methods=['GET'])
def getFormRgister(arg):
    form = db.session.query(Form).filter(Form.code == arg).first()
    return form_schema.jsonify(form)

##################
# Upload File
##################


@app.route('/upload', methods=['POST'])
def upload_base64_file():
    data = request.get_json()
    if data is None:
        print("No valid request body, json missing!")
        return jsonify({'error': 'No valid request body, json missing!'})
    else:
        bytes = b64decode(data, validate=True)
        f = open('D:\DEV\Projects\khalid\file.pdf', 'wb')
        f.write(bytes)
        f.close()


@app.route('/', methods=['GET'])
def index():
    return jsonify({'message': 'Welcome to CCM API'})


if __name__ == "__main__":
    app.run(debug=True)
