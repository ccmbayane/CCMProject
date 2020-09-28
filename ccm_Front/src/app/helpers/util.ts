function parse_config(data) {
  return data.profile.privileges.map((item, index) => {
    return {
      count: item.form[0] ? parseInt(item.form[0].count) : 0,
      current: 1,
      next_button: item.form[0] ? item.form[0].next_button : 'Next',
      previous_button: item.form[0] ? item.form[0].previous_button : 'Previous',
      done_button: item.form[0] ? item.form[0].done_button : 'Done',
      code: item.form[0] ? item.form[0].code : '',
      steps: item.form[0]
        ? item.form[0].formStep.map((itemStep, indexStep) => {
            return {
              title: itemStep.title,
              fields: itemStep.fields.map((itemField, indexField) => {
                return {
                  id: itemField.id,
                  name: itemField.name,
                  placeholder: itemField.placeholder,
                  title: itemField.title,
                  type: itemField.type,
                  value: itemField.value
                };
              })
            };
          })
        : []
    };
  });
}

function parse_config_register(data) {
  return {
    count: data ? parseInt(data.count) : 0,
    current: 1,
    next_button: data ? data.next_button : 'Next',
    previous_button: data ? data.previous_button : 'Previous',
    done_button: data ? data.done_button : 'Done',
    code: data ? data.code : '',
    steps: data
      ? data.formStep.map((itemStep, indexStep) => {
          return {
            title: itemStep.title,
            fields: itemStep.fields.map((itemField, indexField) => {
              return {
                id: itemField.id,
                name: itemField.name,
                placeholder: itemField.placeholder,
                title: itemField.title,
                type: itemField.type,
                value:
                  itemField.type === 'select'
                    ? itemField.fieldValues
                    : itemField.value
              };
            })
          };
        })
      : []
  };
}

export { parse_config, parse_config_register };
