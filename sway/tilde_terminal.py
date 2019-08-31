import sys
import subprocess
import json


def search_node(x,pred):
    if pred(x):
        return x
    else:
        if 'nodes' in x:
            for i in x['nodes']:
                r = search_node(i,pred)
                if r:
                    return r
        if 'floating_nodes' in x:
            for i in x['floating_nodes']:
                r = search_node(i,pred)
                if r:
                    return r
    return None


def get_term_window_y():
    outs = subprocess.check_output(['swaymsg', '-t', 'get_tree'], text=True)
    j = json.loads(outs)
    obj = search_node(j, lambda node: 'app_id' in node and node['app_id'] == 'tildeterminal')
    #print(obj)
    if obj:
        return obj['rect']['y']
    return 0


def call_on_window(command):
    subprocess.call(['swaymsg', '--', '[app_id="^tildeterminal$"]'] + command.split())


roll_height = 400
step = 400


def animate_roll_up():
    for y in range(0, roll_height+1, step):
        call_on_window('move position 0 %d' % (-y))
    call_on_window('focus mode_toggle')


def animate_roll_down():
    call_on_window('focus')
    for y in range(0, roll_height+1, step):
        call_on_window('move position 0 %d' % (y-roll_height))


def roll_up():
    call_on_window('move position 0 %d, focus mode_toggle' %(-roll_height))


def roll_down():
    call_on_window('focus, move position 0 0')


def show_or_hide():
    y = get_term_window_y()
    print(y)
    if y >= 0:
        #  animate_roll_up()
        roll_up()
    else:
        #  animate_roll_down()
        roll_down()


show_or_hide()



