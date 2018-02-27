// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import SVG from "svg.js"
import svgPanZoom from "svg-pan-zoom"

(function () {
  const gridWidth = 800, gridHeight = 800;
  const draw = SVG('grid').size(800, 800);

  const makeGrid = function (draw, rowSpan, colSpan) {
    const grid = [];
    for (let row = 0; row < 100; row++) {
      grid[row] = [];
      for (let col = 0; col < 100; col++) {
        grid[row][col] = {};
        grid[row][col].border = draw.rect(9, 9).move(7 * row, 7 * col).fill('white');
        grid[row][col].square = draw.rect(7, 7).move(7 * row + 1, 7 * col + 1).fill('blue');
        grid[row][col].square.on('mouseover', function (row, col) {
          rowSpan.textContent = row;
          colSpan.textContent = col;
        }.bind(null, row, col));
      }
    }
    draw.on('mouseleave', function () {
      rowSpan.textContent = '-';
      colSpan.textContent = '-';
    });
    return grid;
  };

  const grid = makeGrid(draw, document.getElementById('row'), document.getElementById('col'));

  const panZoomInstance = svgPanZoom('#grid svg', {
    minZoom: 0.5,
    maxZoom: 10,
    zoomScaleSensitivity: 0.1,
    controlIconsEnabled: true
  });
})();