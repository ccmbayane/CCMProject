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
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { parse_config_register } from 'src/app/helpers/util';

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

  private common_url: string = environment.url;
  index;
  payload = [{}];
  validateForm: FormGroup[] = [];
  visible: boolean = false;

  constructor(
    private config: ConfigurationService,
    private router: Router,
    private fb: FormBuilder,
    private authService: AuthentitcationService,
    private http: HttpClient
  ) {}
  ngOnChanges(changes: SimpleChanges): void {
    this.visible = false;
    this.current_steps = this.config.fetch(changes['steps'].currentValue)
      ? this.config.fetch(changes['steps'].currentValue)
      : { steps: [] };
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
      this.current_steps.steps.forEach((item) => {
        const obj = {};
        item.fields.forEach((field) => {
          obj[field.name] = [null, [Validators.required]];
        });
        this.validateForm.push(this.fb.group(obj));
      });
    } else {
      this.validateForm.push(this.fb.group({}));
    }
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
    // this.validateForm[this.current - 1].value.password = 'admin';

    this.payload = this.validateForm.map((item) => {
      let obj = {};
      for (const key in item.controls) {
        if (Object.prototype.hasOwnProperty.call(item.controls, key)) {
          if (item.controls[key].value instanceof Date) {
            const val = item.controls[key].value;
            obj[key] = `${val.toISOString()}`;
          } else {
            obj[key] = item.controls[key].value;
          }
        }
      }
      return obj;
    });
    this.visible = !this.visible;
    // this.authService.create(`/utilisateurs`, payload)
  }

  handleOk(): void {
    this.visible = !this.visible;
  }

  handleCancel(event) {
    this.visible = !this.visible;
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
    return /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/.exec(password);
  }

  email_validator(email: string) {
    return /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$g/.exec(email);
  }
}
