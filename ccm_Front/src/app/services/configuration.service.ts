import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { isInteger } from 'ng-zorro-antd/core/util';

@Injectable({
  providedIn: 'root'
})
export class ConfigurationService {
  private common_url: string = environment.url;
  privileges: [];
  steps: [];
  constructor(private http: HttpClient) {}

  fetch(url) {
    const currentUser: any = JSON.parse(localStorage.getItem('current-user'));
    console.log(currentUser);

    this.privileges = currentUser.profile.privileges;
    this.steps = currentUser.profile.privileges.map((item, index) => {
      return {
        count: item.form[0] ? parseInt(item.form[0].count) : 0,
        current: 1,
        next_button: item.form[0] ? item.form[0].next_button : 'Next',
        previous_button: item.form[0]
          ? item.form[0].previous_button
          : 'Previous',
        done_button: item.form[0] ? item.form[0].done_button : 'Done',
        code: item.form[0] ? item.form[0].code : 'register',
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

    return url === 'menu'
      ? this.privileges
      : this.steps.find((step: any) => step.code === url);
  }
}
