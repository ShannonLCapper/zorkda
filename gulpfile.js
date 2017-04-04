var gulp = require("gulp");
var concat = require("gulp-concat");
var rename = require("gulp-rename");
var uglify = require("gulp-uglify");

//script paths
var jsDest = "public/dist/angular",
    allJsFiles = "public/assets/angular/**/*.js",
    jsFiles = [
      "public/assets/angular/**/*.module.js",
      allJsFiles
    ];

gulp.task("scripts", function(){
  return gulp.src(jsFiles)
    .pipe(concat("scripts.js"))
    .pipe(gulp.dest(jsDest))
    .pipe(rename("scripts.min.js"))
    .pipe(uglify())
    .pipe(gulp.dest(jsDest));
});


//CSS paths
var cssDest = "public/dist/styles",
    cssFiles = "public/assets/styles/**/*.css";

gulp.task("styles", function(){
  return gulp.src(cssFiles)
    .pipe(concat("styles.css"))
    .pipe(gulp.dest(cssDest))
});

gulp.task("watch", function() {
  gulp.watch(cssFiles, ["styles"])
  gulp.watch(allJsFiles, ["scripts"])
});

gulp.task("default", ["scripts", "styles", "watch"]);