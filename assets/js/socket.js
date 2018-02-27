import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createGridSocket = (callback) => {
  let channel = socket.channel('grid', {});

  channel.join()
    .receive('ok', resp => {
      callback(null, resp);
    })
    .receive('error', resp => {
      callback(resp, null);
    });

  channel.on('grid:update', updateGrid);
};

function updateGrid(event) {
  console.log(event);
}

window.createGridSocket = createGridSocket;
