---
title: Game of Life
layout: single
---
---
title: Game of Life
layout: single
---

<style>
    canvas {
        border: 1px solid #000;
        background-color: #000;
    }
</style>

<canvas id="gameOfLifeCanvas"></canvas>

<script>
    const canvas = document.getElementById('gameOfLifeCanvas');
    const ctx = canvas.getContext('2d');

    const cellSize = 10;  // Size of each cell
    const rows = 60;      // Number of rows
    const cols = 80;      // Number of columns
    canvas.width = cols * cellSize;
    canvas.height = rows * cellSize;

    // Create a 2D array (grid)
    let grid = new Array(rows).fill(null).map(() => new Array(cols).fill(0));

    // Randomly populate the grid with live (1) and dead (0) cells
    function randomizeGrid() {
        for (let row = 0; row < rows; row++) {
            for (let col = 0; col < cols; col++) {
                grid[row][col] = Math.random() < 0.3 ? 1 : 0;
            }
        }
    }

    // Draw the grid on the canvas
    function drawGrid() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        for (let row = 0; row < rows; row++) {
            for (let col = 0; col < cols; col++) {
                ctx.fillStyle = grid[row][col] ? '#00FF00' : '#000000';
                ctx.fillRect(col * cellSize, row * cellSize, cellSize, cellSize);
            }
        }
    }

    // Count the number of live neighbors for a given cell
    function countNeighbors(grid, x, y) {
        let sum = 0;
        for (let i = -1; i <= 1; i++) {
            for (let j = -1; j <= 1; j++) {
                const row = (x + i + rows) % rows;
                const col = (y + j + cols) % cols;
                sum += grid[row][col];
            }
        }
        sum -= grid[x][y];  // Subtract the cell itself
        return sum;
    }

    // Update the grid based on Game of Life rules
    function updateGrid() {
        const newGrid = new Array(rows).fill(null).map(() => new Array(cols).fill(0));

        for (let row = 0; row < rows; row++) {
            for (let col = 0; col < cols; col++) {
                const neighbors = countNeighbors(grid, row, col);

                // Game of Life rules
                if (grid[row][col] === 1) {
                    // Cell is alive
                    if (neighbors === 2 || neighbors === 3) {
                        newGrid[row][col] = 1;  // Survives
                    }
                } else {
                    // Cell is dead
                    if (neighbors === 3) {
                        newGrid[row][col] = 1;  // Becomes alive
                    }
                }
            }
        }

        grid = newGrid;
    }

    // Animation loop
    function gameLoop() {
        updateGrid();
        drawGrid();
        requestAnimationFrame(gameLoop);
    }

    // Start the game
    randomizeGrid();
    gameLoop();
</script>
