import { ComponentFixture, TestBed } from '@angular/core/testing';
import { IqbalPage } from './iqbal.page';

describe('IqbalPage', () => {
  let component: IqbalPage;
  let fixture: ComponentFixture<IqbalPage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(IqbalPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
