import { Injectable } from '@angular/core';
import { IUser } from './authentitcation.service';
import { UrlSegment } from '@angular/router';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class PermissionService {
  CanAccess(currentUser: Observable<IUser>, currentRoute: UrlSegment[]): boolean {
	// if (currentUser.profile) {
		
	// }
	return true;
  }

  constructor() { }

  isAuthenticated(route: any): boolean {
	  return true;
  }
}
