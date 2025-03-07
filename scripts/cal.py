#!/usr/bin/env python3
import gi

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk


class DialogExample(Gtk.Dialog):
  def __init__(self, parent):
    super().__init__(title="My Dialog", transient_for=parent, flags=0)
    self.add_buttons(
      Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL, Gtk.STOCK_OK, Gtk.ResponseType.OK
    )


    label = Gtk.Label(label="This is a dialog to display additional information")

    box = self.get_content_area()
    box.add(label)
    self.show_all()

class DialogWindow(Gtk.Window):
  def __init__(self):
    Gtk.Window.__init__(self, title="psychotropic_bar_cal")

    self.set_border_width(6)

    self.set_default_size(450, 300)
    self.set_resizable(False)
    self.set_keep_above(True)
    self.set_decorated(False)
    self.move(0, 0)

    button = Gtk.Button(label="Open dialog")
    button.connect("clicked", self.on_button_clicked)

    #self.add(button)

  def on_button_clicked(self, widget):
    dialog = DialogExample(self)
    response = dialog.run()

    if response == Gtk.ResponseType.OK:
      print("The OK button was clicked")
    elif response == Gtk.ResponseType.CANCEL:
      print("The Cancel button was clicked")

    dialog.destroy()


win = DialogWindow()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()
