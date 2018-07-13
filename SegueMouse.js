var segue = false;

WorkerScript.onMessage = function(msg) {

    if (typeof msg === Boolean) {

        segue = msg;
    }

    else if (segue) {

        WorkerScript.sendMessage(msg);
    }
}
