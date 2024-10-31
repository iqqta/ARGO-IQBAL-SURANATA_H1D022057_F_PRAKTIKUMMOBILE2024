import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { IqbalPage } from './iqbal.page';

const routes: Routes = [
  {
    path: '',
    component: IqbalPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class IqbalPageRoutingModule {}
