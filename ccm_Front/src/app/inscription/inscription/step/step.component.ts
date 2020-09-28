import {
  Component,
  OnInit,
  Input,
  OnChanges,
  SimpleChanges
} from '@angular/core';
import { ConfigurationService } from 'src/app/services/configuration.service';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import {
  AuthentitcationService,
  IUser
} from 'src/app/services/authentitcation.service';
import { throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';

@Component({
  selector: 'app-step',
  templateUrl: './step.component.html',
  styleUrls: ['./step.component.css']
})
export class StepComponent implements OnInit, OnChanges {
  @Input('steps') steps: string;
  public current_steps: any;

  current;
  count;
  next_button;
  previous_button;
  done_button;
  current_form;

  index;

  validateForm: FormGroup[] = [];

  constructor(
    private config: ConfigurationService,
    private router: Router,
    private fb: FormBuilder,
    private authService: AuthentitcationService
  ) {}
  ngOnChanges(changes: SimpleChanges): void {
    console.log(this.config.fetch(changes['steps'].currentValue));

    this.current_steps = this.config.fetch(changes['steps'].currentValue)
      ? this.config.fetch(changes['steps'].currentValue)
      : { steps: [] };
    console.log(this.current_steps);
    this.current = this.current_steps?.current;
    this.count = this.current_steps?.count;
    this.next_button = this.current_steps?.next_button;
    this.previous_button = this.current_steps?.previous_button;
    this.done_button = this.current_steps?.done_button;
    this.changeContent();
  }

  submitForm(): void {}

  ngOnInit(): void {
    this.current_steps = this.config.fetch(this.steps)
      ? this.config.fetch(this.steps)
      : { steps: [] };
    if (this.current_steps?.steps && this.current_steps.steps.length > 0) {
      console.log('here');

      this.current_steps.steps.forEach((item) => {
        const obj = {};
        item.fields.forEach((field) => {
          obj[field.name] = [null, [Validators.required]];
        });
        this.validateForm.push(this.fb.group(obj));
      });
    } else {
      console.log('zejfhkjhkzje');

      this.validateForm.push(this.fb.group({}));
    }
    console.log(this.validateForm);
  }

  pre(): void {
    this.current -= 1;
    this.changeContent();
  }

  next(): void {
    this.current += 1;
    this.changeContent();
  }

  done(): void {
    this.validateForm[this.current - 1].value.password = 'admin';
    console.log(this.validateForm);

    // this.authService
    //   .create('/utilisateurs', this.validateForm[this.current - 1].value)
    //   .pipe(
    //     catchError((e) => {
    //       return throwError(e);
    //     })
    //   )
    //   .subscribe((user: any) => {
    //     console.log(user);
    //   });
    // this.router.navigate(['/inscription']);
  }

  upload(event) {
    const file = event.target.files[0];
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onloadend = () => {
      console.log(reader.result);
    };
  }

  changeContent(): void {
    this.current_form = this.current_steps?.steps[this.current - 1]
      ? this.current_steps.steps[this.current - 1].fields
      : [];
    console.log(this.current_steps?.steps[this.current - 1]);
  }

  password_validator(password: string) {
    return /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$gm/.exec(
      password
    );
  }

  email_validator(email: string) {
    return /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$g/.exec(email);
  }
}
