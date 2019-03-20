function setFrame() {
    let iframe = document.createElement('iframe');
  iframe.setAttribute('src', window.state.url);
  iframe.setAttribute('width', '100%;');
  iframe.setAttribute('height', '100%;');
  iframe.setAttribute('style', 'border-style: none !important;');
  let inner = document.getElementById("frame");
  inner.innerHTML = "";
  inner.appendChild(iframe);
  iframe.focus();
}

function doSub() {
  window.urb.subscribe(window.ship, "modulo", "/applist",
    (err) => {
      console.log(err);
    },
    (event) => {
      console.log(event);
      window.state = event;
      setFrame();
    },
    () => {
      doSub();
    }
  );
}

var palette = false;

window.addEventListener("message", (event) => {
  let popup = document.getElementById("popup");
  let input = document.getElementById("input");

  if (palette) {
    palette = false;
    popup.style = "display:hidden;";
    input.style = "visibility:hidden !important;";
    input.value = "";
  } else {
    palette = true;

    popup.style = "position:absolute; left: 0; top: 0; display:block; width: 100%; height: 100%; margin: 0 0; background-color:white;";
    input.style = "";
    input.focus();
    input.addEventListener("keyup", (e) => {
      if (e.keyCode !== 13) { return; }
      popup.style = "display:hidden;";
      popup.style = "visibility:hidden !important;";

      window.urb.poke(window.ship, "modulo", "modulo-command", 
        {
          go: input.value
        },
        (json) => {
          console.log(json);
        },
        (err) => {
          console.log(err);
        }
      );

    });
  }
});

setFrame();
doSub();
