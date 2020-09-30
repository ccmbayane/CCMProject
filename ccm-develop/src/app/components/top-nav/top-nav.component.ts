import {
  Component,
  OnInit,
  OnChanges,
  SimpleChanges,
  Input
} from '@angular/core';
import { ConfigurationService } from 'src/app/services/configuration.service';
import { Router } from '@angular/router';
import { AuthentitcationService } from 'src/app/services/authentitcation.service';

@Component({
  selector: 'app-top-nav',
  templateUrl: './top-nav.component.html',
  styleUrls: ['./top-nav.component.css']
})
export class TopNavComponent implements OnInit, OnChanges {
  menus: any;
  active: boolean = false;
  @Input('mode') mode: string;
  dark = false;

  constructor(
    private config: ConfigurationService,
    private router: Router,
    private auth: AuthentitcationService
  ) {
    this.menus = this.config.fetch('menu');
  }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['steps']) this.menus = this.config.fetch('menu');
  }

  ngOnInit(): void {}

  goto(item, secondItem?) {
    if (item.path === '/logout') {
      localStorage.clear();
      this.auth.isLoggindIn.next(false);
      this.auth.currentUser.next(null);
      this.router.navigate(['/login']);
      return 0;
    }

    this.menus = this.menus.map((menuItem) => {
      if (secondItem) {
        secondItem.id === menuItem.id
          ? (menuItem.active = true)
          : (menuItem.active = false);
        return menuItem;
      }
      item.id === menuItem.id
        ? (menuItem.active = true)
        : (menuItem.active = false);
      return menuItem;
    });

    this.router.navigate([item.path]);

    return 0;
  }
}
