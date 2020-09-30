import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { parse_config, parse_config_register } from '../helpers/util';
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

    if (!currentUser) {
      let register_config = localStorage.getItem('register_config' + url);
      if (register_config) {
        return JSON.parse(register_config);
      } else {
        this.http.get(`${this.common_url}/forms/${url}`).subscribe((result) => {
          localStorage.setItem(
            'register_config' + url,
            JSON.stringify(parse_config_register(result))
          );
        });
        return JSON.parse(localStorage.getItem('register_config' + url));
      }
    }

    this.privileges = currentUser.profile.privileges;
    this.steps = parse_config(currentUser);

    return url === 'menu'
      ? this.privileges
      : this.steps.find((step: any) => step.code === url);
  }
}
