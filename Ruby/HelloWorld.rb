require 'tk'

app = TkRoot.new {
	title "Hello, TK!"; padx 100; pady 100
}

lbl = TkLabel.new(app) {
	text "Something was not clicked yet..."
	pack {padx 100; pady 100; side "center"}
}

java_clicked = Proc.new {
	lbl.text "Java was liked..."
}

cs_clicked = Proc.new {
	lbl.text "C# was liked..."
}

cpp_clicked = Proc.new {
	lbl.text "C++ was liked..."
}

py_clicked = Proc.new {
	lbl.text "Python was liked..."
}

rb_clicked = Proc.new {
	lbl.text "Ruby was liked..."
}

menu = TkMenu.new(app)

menu.add('command', 'label' => "Java", 'command' => java_clicked)
menu.add('command', 'label' => "C#", 'command' => cs_clicked)
menu.add('separator')
menu.add('command', 'label' => "C++", 'command' => cpp_clicked)
menu.add('separator')
menu.add('command', 'label' => "Python", 'command' => py_clicked)
menu.add('command', 'label' => "Ruby", 'command' => rb_clicked)

bar = TkMenu.new
bar.add('cascade', 'menu' => menu, 'label' => "Click me, I want you!")
app.menu(bar)

Tk.mainloop