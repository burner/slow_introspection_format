# How to

The source code in source/app.d is a highly slimmed down version of the
typescript generation we do for our work project.
I think the code is very idiomatic/tasteful D.
Yet we can't really do this in this way anymore, as the compiler takes to long
compiling it.

I know how to improve compile performance, but I should not have to do it.
Changes to phobos can also not be the solution in my opinion as I consider the
D in phobos more idiomatic than mine in the first place.

Dennis' tutorial on how to use ldc to track compile times is awesome.
The two steps below should be enough to get started.

1. dub build --compiler=ldc (generates trace.json)
2. using chrome(chromium) browse to chrome://tracing and load trace.json file
   from this folder


