import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../environments/environment';
import { BehaviorSubject, Observable } from 'rxjs';
@Injectable({
  providedIn: 'root'
})
export class AuthentitcationService {
  private common_url: string = environment.url;
  public currentUser = new BehaviorSubject<IUser>(null);
  public isLoggindIn = new BehaviorSubject<boolean>(false);
  constructor(private http: HttpClient) {}

  login(url, form): Observable<any> {
    return this.http.get<any>(`${this.common_url}/utilisateurs/1`);
  }

  create(url, form): Observable<any> {
    return this.http.post<any>(`${this.common_url}${url}`, form);
  }

  getCurrentUser() {
    return this.currentUser;
  }
}

export interface IUser {
  username: string;
  password: string;
  name: {
    firstname: string;
    lastname: string;
    fullname: string;
  };
  profile: string;
}
