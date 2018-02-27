import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createGridSocket = () => {
  let channel = socket.channel('grid', {});

  channel.join()
    .receive('ok', resp => {
      console.log(resp);
    })
    .receive('error', resp => {
      console.log('Unable to join:', resp);
    });

  channel.on('grid:update', updateGrid);
};

function updateGrid(event) {
  console.log(event);
}

window.createGridSocket = createGridSocket;
