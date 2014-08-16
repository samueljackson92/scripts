// gol.js
// Date: 15/06/13
// Author: Samuel Jackson (samueljackson@outlook.com)
// Description: JavaScript implementation of Conway's game of life.

var canvas;
var canvasElem;
var ctx;
var CELL_SIZE = 8;
var GRID_SIZE;
var g;

var btnStep;
var btnRun;
var btnPause;
var btnFaster;
var btnSlower;
var btnReset;
var info;

var timeoutSpeed = 500;
var drawHandle;

(function($){
	$(document).ready(function() {
		canvasElem = $("#viewport");
		canvas = canvasElem[0];
		ctx = canvas.getContext('2d');
		GRID_SIZE = canvas.width / CELL_SIZE;

		g = new grid();

		//get buttons from HTML
		btnStep = $('#step');
		btnRun = $('#run');
		btnPause = $('#pause');

		btnFaster = $('#faster');
		btnSlower = $('#slower');

		btnReset = $('#reset');

		info = $("#info");

		//register event handlers
		btnStep.on('click', performStep);
		btnRun.on('click', run);
		btnPause.on('click', pause);

		btnFaster.on('click', function() { (timeoutSpeed > 100) ? timeoutSpeed-= 100 : timeoutSpeed = 100;});
		btnSlower.on('click', function() { timeoutSpeed+= 100; });
		btnReset.on('click', reset);

		canvasElem.on('click', onCanvasClick);

		drawGrid();
	});
})(this.jQuery);

function onCanvasClick(evt) {
	var x = evt.pageX - canvas.offsetLeft;
	var y = evt.pageY - canvas.offsetTop;

	//round to nearest cell
	x = x - (x%CELL_SIZE) + CELL_SIZE/2;
	y = y - (y%CELL_SIZE) + CELL_SIZE/2;

	x = Math.floor(x/CELL_SIZE);
	y = Math.floor(y/CELL_SIZE);

	var val = (g.getCell(x,y) === 1) ? 0 : 1;
	g.setCell(x,y,val);
	drawGrid();
}

function performStep() {
	canvasElem.off('click');
	g.step();
	drawGrid();
}

function updateInfo() {
	info.html("<span><b>Generation:</b> "+g.generations+"</span><span><b>No. Living Cells:</b> "+g.livingCells+"</span><span><b>Max Living Cells:</b> "+g.maxLivingCells+"</span>");
}

function run() {
	btnStep.addClass('disabled');
	performStep();
	drawHandle = setTimeout(run, timeoutSpeed);
}

function pause() {
	btnStep.removeClass('disabled');
	clearTimeout(drawHandle);
}

function reset() {
	canvasElem.on('click', onCanvasClick);
	pause();
	g = new grid();
	clearGrid();
	updateInfo();
}

function drawSquare(x,y,d) {
	ctx.fillStyle="#000000";
	ctx.fillRect(x,y,d,d);
}

function clearGrid() {
	ctx.clearRect (0, 0, canvas.width, canvas.height);
}

function drawGrid() {
	clearGrid();
	g.livingCells = 0;
	g.eachCell(function(val, x, y){
		if(val === 1) {
			g.livingCells++;
			drawSquare(x*CELL_SIZE,y*CELL_SIZE, CELL_SIZE);
		}
	});
	updateInfo();
}