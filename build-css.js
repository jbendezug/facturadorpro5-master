const sass = require('sass');
const path = require('path');
const fs = require('fs');

const result = sass.compile(
  path.resolve(__dirname, 'resources/sass/style.scss'),
  {
    loadPaths: [path.resolve(__dirname, 'node_modules')],
    style: 'expanded',
    sourceMap: true,
    sourceMapIncludeSources: true,
    quietDeps: true
  }
);

fs.writeFileSync(
  path.resolve(__dirname, 'public/css/app.css'),
  result.css
);

if (result.sourceMap) {
  fs.writeFileSync(
    path.resolve(__dirname, 'public/css/app.css.map'),
    JSON.stringify(result.sourceMap)
  );
}

// Also compile auth.scss
const resultAuth = sass.compile(
  path.resolve(__dirname, 'resources/sass/auth.scss'),
  {
    style: 'expanded',
    sourceMap: true,
    sourceMapIncludeSources: true,
    quietDeps: true
  }
);

fs.writeFileSync(
  path.resolve(__dirname, 'public/css/auth.css'),
  resultAuth.css
);

if (resultAuth.sourceMap) {
  fs.writeFileSync(
    path.resolve(__dirname, 'public/css/auth.css.map'),
    JSON.stringify(resultAuth.sourceMap)
  );
}

console.log('CSS compiled successfully!');
console.log(`app.css: ${(result.css.length / 1024).toFixed(0)}KB`);
console.log(`auth.css: ${(resultAuth.css.length / 1024).toFixed(0)}KB`);
