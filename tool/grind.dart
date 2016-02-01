import 'package:grinder/grinder.dart';

main(args) => grind(args);

@Task()
@Depends(test)
build() {
}

@Task()
@Depends(analyze)
test() {
    new TestRunner().test(files: "test");

    // Alle test mit @TestOn("content-shell") im header
    // new TestRunner().test(files: "test",platformSelector: "content-shell");
}

@Task()
analyze() {
    final List<String> libs = [
        "lib/mustache.dart"
    ];

    libs.forEach((final String lib) => Analyzer.analyze(lib));
    Analyzer.analyze("test");
}

@Task()
clean() => defaultClean();