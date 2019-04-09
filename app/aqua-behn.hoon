/-  aquarium
=,  aquarium
=>  |%
    +$  move  (pair bone card)
    +$  card
      $%  [%poke wire dock %aqua-events (list aqua-event)]
          [%peer wire dock path]
          [%pull wire dock ~]
          [%wait wire p=@da]
          [%rest wire p=@da]
      ==
    ::
    +$  state
      $:  %0
          subscribed=_|
          piers=(map ship pier)
      ==
    ::
    +$  pier  next-timer=(unit @da)
    --
=,  gall
=|  moves=(list move)
|_  $:  bowl
        state
    ==
++  this  .
++  apex  %_(this moves ~)
++  abet  [(flop moves) this]
++  emit-moves
  |=  ms=(list move)
  %_(this moves (weld ms moves))
::
++  emit-aqua-events
  |=  aes=(list aqua-event)
  %-  emit-moves
  [ost %poke /aqua-events [our %aqua] %aqua-events aes]~
::
++  poke-aqua-vane-control
  |=  command=?(%subscribe %unsubscribe)
  :_  this(subscribed =(command %subscribe))
  (aqua-vane-control-handler our ost subscribed command)
::
++  diff-aqua-effects
  |=  [way=wire afs=aqua-effects]
  ^-  (quip move _this)
  =.  this  apex  =<  abet
  |-  ^+  this
  ?~  ufs.afs
    this
  =.  this
    ?+  -.q.i.ufs.afs  this
      %sleep    abet-pe:handle-sleep:(pe who.afs)
      %restore  abet-pe:handle-restore:(pe who.afs)
      %doze     abet-pe:(handle-doze:(pe who.afs) i.ufs.afs)
    ==
  $(ufs.afs t.ufs.afs)
::
::  Received timer wake
::
++  wake
  |=  [way=wire error=(unit tang)]
  ^-  (quip move _this)
  =.  this  apex  =<  abet
  ?>  ?=([@ *] way)
  =/  who  (,@p (slav %p i.way))
  abet-pe:(take-wake:(pe who) t.way error)
::
++  pe
  |=  who=ship
  =+  (fall (~(get by piers) who) *pier)
  =*  pier-data  -
  |%
  ++  abet-pe
    ^+  this
    =.  piers  (~(put by piers) who pier-data)
    this
  ::
  ++  handle-sleep
    ^+  ..abet-pe
    =<  ..abet-pe(pier-data *pier)
    ?~  next-timer
      ..abet-pe
    cancel-timer
  ::
  ++  handle-restore
    ^+  ..abet-pe
    =.  this
      %-  emit-aqua-events
      [%event who [//behn/0v1n.2m9vh %born ~]]~
    ..abet-pe
  ::
  ++  handle-doze
    |=  [way=wire %doze tim=(unit @da)]
    ^+  ..abet-pe
    ?~  tim
      ?~  next-timer
        ..abet-pe
      cancel-timer
    ?~  next-timer
      (set-timer u.tim)
    (set-timer:cancel-timer u.tim)
  ::
  ++  set-timer
    |=  tim=@da
    ~?  debug=|  [who=who %setting-timer tim]
    =.  next-timer  `tim
    =.  this  (emit-moves [ost %wait /(scot %p who) tim]~)
    ..abet-pe
  ::
  ++  cancel-timer
    ~?  debug=|  [who=who %cancell-timer (need next-timer)]
    =.  this  (emit-moves [ost %rest /(scot %p who) (need next-timer)]~)
    =.  next-timer  ~
    ..abet-pe
  ::
  ++  take-wake
    |=  [way=wire error=(unit tang)]
    ~?  debug=|  [who=who %aqua-behn-wake now error=error]
    =.  next-timer  ~
    =.  this
      %-  emit-aqua-events
      :_  ~
      ^-  aqua-event
      :+  %event  who
      :-  //behn/0v1n.2m9vh
      ?~  error
        [%wake ~]
      [%crud %fail u.error]
    ..abet-pe
  --
--
