import { Component, OnInit, OnChanges, SimpleChanges } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import {
  AuthentitcationService,
  IUser
} from '../services/authentitcation.service';
import { map, catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit, OnChanges {
  validateForm: FormGroup;
  constructor(
    private fb: FormBuilder,
    private auth: AuthentitcationService,
    private router: Router
  ) {
    this.validateForm = this.fb.group({
      userName: [null, [Validators.required]],
      password: [null, [Validators.required]],
      remember: [true]
    });
  }

  ngOnChanges(changes: SimpleChanges): void {
    this.validateForm = this.fb.group({
      userName: [null, [Validators.required]],
      password: [null, [Validators.required]],
      remember: [true]
    });
  }

  submitForm(): void {
    this.auth
      .login('/auth/login', this.validateForm.value)
      .pipe(
        catchError((e) => {
          return throwError(e);
        })
      )
      .subscribe((user: any) => {
        // const user = {
        // 	username: "string",
        // 	password: "string",
        // 	name: {
        // 		firstname: "string",
        // 		lastname: "string",
        // 		fullname: "string",
        // 	},
        // 	profile: "string",
        // }
        console.log(user);
        this.auth.currentUser.next(user);
        this.auth.isLoggindIn.next(true);
        localStorage.setItem('current-user', JSON.stringify(user));
        this.router.navigate(['/']);
      });
  }

  ngOnInit(): void {}
}
