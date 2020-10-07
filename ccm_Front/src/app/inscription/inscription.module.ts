import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { InscriptionComponent } from './inscription/inscription.component';
import { Routes, RouterModule } from '@angular/router';
import { NzStepsModule } from 'ng-zorro-antd/steps';
import { AtComponent } from './inscription/at/at.component';
import { StepComponent } from './inscription/step/step.component';
import { NzSelectModule } from 'ng-zorro-antd/select';
import { ReactiveFormsModule } from '@angular/forms';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzFormModule } from 'ng-zorro-antd/form';
import { NzInputModule } from 'ng-zorro-antd/input';
import { IconDefinition } from '@ant-design/icons-angular';
import {
  AccountBookFill,
  AlertFill,
  AlertOutline
} from '@ant-design/icons-angular/icons';
import { NzDatePickerModule } from 'ng-zorro-antd/date-picker';
import { RegisterComponent } from './register/register.component';
import { AuthenticationGuard } from '../services/authentication.guard';
import { NzIconModule } from 'ng-zorro-antd/icon';
// import { NzModalModule } from 'ng-zorro-antd/modal/modal.module';
import { NzModalModule } from 'ng-zorro-antd/modal';
const icons: IconDefinition[] = [AccountBookFill, AlertOutline, AlertFill];

const routes: Routes = [
  {
    path: '',
    component: AtComponent,
    canActivate: [AuthenticationGuard]
  },
  {
    path: 'inscr',
    component: InscriptionComponent,
    canActivate: [AuthenticationGuard]
  },
  {
    path: 'register',
    component: RegisterComponent
  }
];

@NgModule({
  declarations: [
    InscriptionComponent,
    AtComponent,
    StepComponent,
    RegisterComponent
  ],
  imports: [
    CommonModule,
    NzStepsModule,
    NzSelectModule,
    ReactiveFormsModule,
    NzButtonModule,
    NzFormModule,
    NzIconModule.forRoot(icons),
    NzInputModule,
    NzModalModule,
    NzDatePickerModule,
    RouterModule.forChild(routes)
  ],
  providers: [AuthenticationGuard]
})
export class InscriptionModule {}
