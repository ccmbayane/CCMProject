import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DossierComponent } from './dossier/dossier.component';
import { Routes, RouterModule } from '@angular/router';

const routes: Routes = [
  {
    path: '',
    component: DossierComponent
  }
];

@NgModule({
  declarations: [DossierComponent],
  imports: [CommonModule, RouterModule.forChild(routes)]
})
export class DossierModule {}
