::  /mar/collections/comment/hoon
::
/-  *collections
|_  com=comment
++  grow
  |%
  ++  mime
    :-  /text/x-collections-comment
    %-  as-octs:mimes:html
    (of-wain:format txt)
  ++  txt
    ^-  (list @t)
    :-  (crip <[by=who.com ed=wed.com]>)
    wat.com
  --
::
++  grab
  |%
  ++  mime
    |=  {p/mite:eyre q/octs:eyre}
    (txt (to-wain:format q.q))
  ++  txt
    |=  txs/(pole @t)  ^+  com
    ?>  ?=([inf=@t wat=*] txs)
    =/  inf  :: REVIEW this seems not v stable
      %-  %-  hard
          $:  %cltr
              [%ktts %by [%sand %p who=@p]]
              [%ktts %ed [%sand %da wed=@da]]
              ~
          ==
      (ream inf.txs)
    [who.inf wed.inf wat.txs]
  --
++  grad  %txt
--