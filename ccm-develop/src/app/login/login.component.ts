import { Component, OnInit, OnChanges, SimpleChanges } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { AuthentitcationService } from '../services/authentitcation.service';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';
import { Router } from '@angular/router';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { parse_config_register } from '../helpers/util';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit, OnChanges {
  validateForm: FormGroup;
  visible: boolean = false;
  common_url = environment.url;

  constructor(
    private fb: FormBuilder,
    private auth: AuthentitcationService,
    private router: Router,
    private http: HttpClient
  ) {
    this.http.get(`${this.common_url}/forms/registerSP`).subscribe((result) => {
      localStorage.setItem(
        'register_configregisterSP',
        JSON.stringify(parse_config_register(result))
      );
    });

    this.http.get(`${this.common_url}/forms/registerPP`).subscribe((result) => {
      localStorage.setItem(
        'register_configregisterPP',
        JSON.stringify(parse_config_register(result))
      );
    });

    this.validateForm = this.fb.group({
      login: [null, [Validators.required]],
      password: [null, [Validators.required]]
    });
  }

  ngOnChanges(changes: SimpleChanges): void {
    this.validateForm = this.fb.group({
      login: [null, [Validators.required]],
      password: [null, [Validators.required]]
    });
  }

  submitForm(): void {
    this.auth
      .login('/utilisateurs/login', this.validateForm.value)
      .pipe(
        catchError((e) => {
          return throwError(e);
        })
      )
      .subscribe((user: any) => {
        this.auth.currentUser.next(user);
        this.auth.isLoggindIn.next(true);
        user.profile.privileges.push({
          active: 'False',
          children: [],
          form: [],
          icon: null,
          path: '/logout',
          title: 'Logout'
        });
        localStorage.setItem('current-user', JSON.stringify(user));
        this.router.navigate(['/']);
      });
  }

  goTo(type): void {
    this.visible = false;
    this.router.navigate(['/inscription/register'], { queryParams: { type } });
  }

  change(value: boolean): void {
    console.log(value);
  }

  ngOnInit(): void {}
}
