module Equity_mod
      implicit none
      private
      public : : Calculate , G et active , Get quote , Print
      type , public :: equityt
              ! active : indicate if stock is volatile
              logical :: active = .false.
              real    :: currentprice = 1.0
              integer : : no_of_shares = 0
      end type equityt
