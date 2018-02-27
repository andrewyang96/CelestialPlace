import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createGridSocket = (callback) => {
  let channel = socket.channel('grid', {});

  channel.join()
    .receive('ok', resp => {
      callback(null, resp, channel);
    })
    .receive('error', resp => {
      callback(resp, null);
    });
};

window.createGridSocket = createGridSocket;
