import "phoenix_html";
import "./socket";

import SVG from "svg.js";
import svgPanZoom from "svg-pan-zoom";

(() => {
  const gridWidth = 800, gridHeight = 800;
  const draw = SVG('grid').size(800, 800);

  const colorFill = (draw, row, col, rgbColor) => {
    return draw.rect(7, 7).move(7 * col + 1, 7 * row + 1).fill('#' + rgbColor);
  }

  const makeGrid = (draw, gridColors, rowSpan, colSpan) => {
    const grid = [];
    for (let row = 0; row < 100; row++) {
      grid[row] = [];
      for (let col = 0; col < 100; col++) {
        grid[row][col] = {};
        grid[row][col].border = draw.rect(9, 9).move(7 * col, 7 * row).fill('white');
        grid[row][col].square = colorFill(draw, row, col, gridColors[row][col]);
        grid[row][col].square.on('mouseover', function (row, col) {
          rowSpan.textContent = row;
          colSpan.textContent = col;
        }.bind(null, row, col));
      }
    }
    draw.on('mouseleave', () => {
      rowSpan.textContent = '-';
      colSpan.textContent = '-';
    });
    return grid;
  };

  window.createGridSocket((err, resp) => {
    if (err) return console.log('Error rendering grid:', err);
    const gridColors = resp.grid;
    const gridArea = makeGrid(draw, gridColors, document.getElementById('row'), document.getElementById('col'));
    const panZoomInstance = svgPanZoom('#grid svg', {
      minZoom: 0.5,
      maxZoom: 10,
      zoomScaleSensitivity: 0.1,
      controlIconsEnabled: true
    });
  });
})();