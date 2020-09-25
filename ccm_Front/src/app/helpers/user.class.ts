export class User {
	constructor(props) {
		this.username = props?.username;
		this.password = props?.password;
		this.firstName = props?.firstName;
		this.lastName = props?.lastName;
		this.email = props?.email;
		this.phoneNumber = props?.phoneNumber;
		this.cin = props?.cin;
		this.passport = props?.passport;
	}
	private username: string;
	private password: string;
	private firstName: string;
	private lastName: string;
	private email: string;
	private phoneNumber: string;
	private cin: string;
	private passport: string;
}