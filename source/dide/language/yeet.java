package dide;public class Main{public static void main(String... args){System.out.println(69);}}
{"language":"java","entry":"Main.java","options":["-q"],"dependencies":{},"files":[{"name":"Main.java","content":"package dide;public class Main{public static void main(String... args){System.out.println(69);}}"}]}
module dide;import std.stdio;void main(string[]args){writeln(69);}
{"language":"dlang","entry":"app.d","options":["-q"],"dependencies":{},"files":[{"name":"app.d","content":"module dide;import std.stdio;void main(string[]args){writeln(69);}"}]}
{"language":"py","entry":"app.py","options":["-q"],"dependencies":{},"files":[{"name":"app.py","content":"print(69)"}]}
{"language":"kt","entry":"Main.kt","options":["-q"],"dependencies":{},"files":[{"name":"Main.kt","content":"package dide\nfun main(){println(69)}"}]}
namespace HelloWorld{class Hello{static void Main(string[] args){System.Console.WriteLine(69);}}}
{"language":"cs","entry":"Program.cs","options":["-q"],"dependencies":{},"files":[{"name":"Program.cs","content":"namespace HelloWorld{class Hello{static void Main(string[] args){System.Console.WriteLine(69);}}}"}]}
{"language":"js","entry":"app.js","options":["-q"],"dependencies":{},"files":[{"name":"app.js","content":"console.log(69);"}]}
{"language":"ts","entry":"app.ts","options":["-q"],"dependencies":{},"files":[{"name":"app.ts","content":"let message:number=69;console.log(message);"}]}
{"language":"go","entry":"app.go","options":["-q"],"dependencies":{},"files":[{"name":"app.go","content":"package main\nimport \"fmt\"\nfunc main(){fmt.Println(69)}"}]}
{"language":"rs","entry":"main.rs","options":["-q"],"dependencies":{},"files":[{"name":"main.rs","content":"fn main(){println!(\"{}\",69);}"}]}

{"language":"d","entry":"app.d","options":["-q"],"dependencies":{},"files":[{"name":"app.d","content":"import mod;import std.stdio;void main(){writeln(add(1,2));}"},{"name":"mod/adder.d","content":"module mod.adder;int add(int a, int b){return a+b;}"},{"name":"mod/package.d","content":"module mod;public import mod.adder;"}]}