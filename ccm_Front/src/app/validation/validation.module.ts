import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ValidationComponent } from './validation/validation.component';
import { Routes, RouterModule } from "@angular/router";

const routes: Routes = [
	{
		path: '',
		component: ValidationComponent
	}
]

@NgModule({
  declarations: [ValidationComponent],
  imports: [
	CommonModule,
	RouterModule.forChild(routes)
  ]
})
export class ValidationModule { }
