function isInArray(value, array) {
    return array.indexOf(value) > -1;
}

function make_question() {

}

function not_enable() {
    for (var i=0;i<9;i++){

        answers.set(i,{"click": false})
    }
}

/// multiplier_lottery() brings new numbers in order to do the multiplication
function multiplier_lottery(_a) {
    var skipped_numbers = [];

    switch (_a) {
    case 0:
    case 1:
    case 2:
        var upper = 3;
        var lower = 0;
        break;
    case 3:
        upper = 11;
        lower = 0;
        for (var i = 3;i<10;i++){
            skipped_numbers.push(i);
        }
        break;
    case 4:
        upper = 11;
        lower = 0;
        for (i = 3;i<10;i++){
            if (i !== 5) {
                skipped_numbers.push(i);
            }
        }
        break;
    case 5:
        upper = 11;
        lower = 0;
        for (i = 4;i<10;i++){
            if (i !== 5) {
                skipped_numbers.push(i);
            }
        }
        break;
    case 6:
        upper = 11;
        lower = 0;
        for (i = 6;i<10;i++){
            skipped_numbers.push(i);
        }
        break;
    case 7:
        upper = 11;
        lower = 0;
        for (i = 7;i<10;i++){
            skipped_numbers.push(i);
        }
        break;
    case 8:
        upper = 11;
        lower = 0;
        for (i = 8;i<10;i++){
            skipped_numbers.push(i);
        }
        break;
    case 9:
        upper = 11;
        lower = 0;
        for (i = 9;i<10;i++){
            skipped_numbers.push(i);
        }
        break;
    case 10:
        upper = 11;
        lower = 0;
        break;
    default:
        upper = _a;
        lower = 0;
    }

    var z = Math.floor(Math.random() * upper)
    while (isInArray(z,skipped_numbers)) {
        z = Math.floor(Math.random() * upper)
    }
    return z
}

// This function sets right and wrong answers to the list model
function fill_answers(_a,_b,_c,_level) {
    _a = Math.floor(Math.random() * (Math.max(11, level)));
    a = _a
    _b = MyFunc.multiplier_lottery(level)
    b = _b
    var valuearray = [];
    var skipped_numbers = [];
    _c = _a * _b;
    var sum_visible = 1; //counts the sum of visible answers
    var right_position = Math.floor(Math.random() * 9);
    valuearray.push(_c);
    // used numbers by levels
    switch (_level) {
    case 0:
        var num_visible = 2;
        var upper = 3;
        var lower = 0;
        break;
    case 1:
        num_visible = 2;
        upper = 3;
        lower = 0;
        break;
    case 2:
        num_visible = 3;
        upper = 3;
        lower = 0;
        break;
    case 3:
        num_visible = 4;
        upper = 11;
        lower = 0;
        for (var i = 3;i<10;i++){
            skipped_numbers.push(i);
        }
        break;
    default:
        num_visible = 5;
        upper = _level;
        lower = 0;
    }

    i=0;
    var round = 0; // To limit while loops
    while (i<9 && round < 12){
        var _visible = Math.random();
        if (_visible < 0.6+i*0.05 && sum_visible < num_visible) {
            var __visible = true;
            //sum_visible++;
        }
        else {__visible = false};
        if (i === right_position) {
            answers.set(i,{"box_color":"blue", "answer":_c, "click": true, "box_visible":true})
        }
        else if (answers.get(i).box_visible === true && round ===1){
            //Do nothing
        }

        else {
            var z = Math.floor(Math.random() * (Math.max(11,_level))) * Math.floor(Math.random() * (upper + 1))
            if ((Math.abs(z-_c)/_c > 0.2) && (Math.abs(z-_c)>_level)) {
                answers.set(i,{"box_color":"blue", "answer":z, "click": true, "box_visible":false})
            }
            else if (isInArray(z, valuearray)) {
                answers.set(i,{"box_color":"blue", "answer":z, "click": true, "box_visible":false})
            }
            else if (__visible) {
                valuearray.push(z);
                answers.set(i,{"box_color":"blue", "answer":z, "click": true, "box_visible":__visible})
                sum_visible++;
            }
            else {
                answers.set(i,{"box_color":"blue", "answer":z, "click": true, "box_visible":false})
            }
        }
        if (i===8 && sum_visible < num_visible) {
            i = 0;
            round = round + 1;
        }
        else {
            i++;
        }
    }
}

function level_check(_level, _level_points) {

    switch (_level) {
    case 0:
        if (_level_points > 11) {return _level + 1};
        break;
    case 1:
        if (_level_points > 17) {return _level + 1};
        break;
    case 2:
        if (_level_points > 23) {return _level + 1};
        break;
    case 3:
        if (_level_points > 29) {return _level + 1};
        break;
    case 4:
        if (_level_points > 37) {return _level + 1};
        break;
    case 5:
        if (_level_points > 47) {return _level + 1};
        break;
    case 6:
        if (_level_points > 57) {return _level + 1};
        break;
    case 7:
        if (_level_points > 67) {return _level + 1};
        break;
    case 8:
        if (_level_points > 79) {return _level + 1};
        break;
    case 9:
        if (_level_points > 89) {return _level + 1};
        break;
    default:
        if (_level_points > _level*_level) {return _level + 1};
        //return 0
    }
}
