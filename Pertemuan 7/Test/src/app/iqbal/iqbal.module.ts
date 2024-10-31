import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { IqbalPageRoutingModule } from './iqbal-routing.module';

import { IqbalPage } from './iqbal.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    IqbalPageRoutingModule
  ],
  declarations: [IqbalPage]
})
export class IqbalPageModule {}
