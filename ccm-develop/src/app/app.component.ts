import { Component } from '@angular/core';
import {
  AuthentitcationService,
  IUser
} from './services/authentitcation.service';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  user;
  collapse = false;
  title = 'ccm';
  constructor(public auth: AuthentitcationService) {
    if (localStorage.getItem('current-user')) {
      this.auth.currentUser.next(
        JSON.parse(localStorage.getItem('current-user'))
      );
      this.auth.isLoggindIn.next(true);
    }
  }

  ngOnInit(): void {
    this.auth.currentUser
      .pipe(
        catchError((e) => {
          return throwError(e);
        })
      )
      .subscribe((user: IUser) => {
        this.user = user;
      });
  }
}
