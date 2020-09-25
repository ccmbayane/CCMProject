import { Component, OnInit } from '@angular/core';
import { ConfigurationService } from '../../services/configuration.service';
import { AuthentitcationService } from 'src/app/services/authentitcation.service';
@Component({
  selector: 'app-inscription',
  templateUrl: './inscription.component.html',
  styleUrls: ['./inscription.component.css']
})
export class InscriptionComponent implements OnInit {
  user;
  constructor() {
    this.user = JSON.parse(localStorage.getItem('current-user'));
  }

  ngOnInit(): void {
    this.user = JSON.parse(localStorage.getItem('current-user'));
  }
}

export interface IField {
  title: string;
  placeholder: string;
  type: string;
  value: any;
}

export interface IStep {
  title: string;
  description: string;
  fields: IField[];
}
