import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  type: any;
  constructor(private activeRoute: ActivatedRoute) {
    this.activeRoute.params.subscribe((params) => {
      this.type = params['type'];
    });
  }

  ngOnInit(): void {}
}
