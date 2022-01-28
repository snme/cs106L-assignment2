#include <iostream>
#include <algorithm>
#include <vector>
#include <unordered_set>
#include "wikiscraper.h"
#include <string>

using std::vector;          using std::string;
using std::unordered_set;   using std::cout;
using std::endl;

const string pre = "<a href=\"wiki/";
const string suf = "\">";

/*********************************************
 * TEST #1: Valid Wikilink Basic Check: valid
 ********************************************/
const string valid_wikilink_test1() {
    return valid_wikilink(pre + "hello" + suf) ? "valid" : "invalid";
}

/*********************************************
 * TEST #2: Valid Wikilink Basic Check: valid
 ********************************************/
const string valid_wikilink_test2() {
    return valid_wikilink(pre + "Czech_Republic" + suf) ? "valid" : "invalid";
}

/*********************************************
 * TEST #3: Valid Wikilink Basic Check: invalid
 ********************************************/
const string valid_wikilink_test3() {
    return valid_wikilink("") ? "valid" : "invalid";
}

/*********************************************
 * TEST #4: Valid Wikilink Basic Check: invalid
 * not a wiki link
 ********************************************/
const string valid_wikilink_test4() {
    return valid_wikilink("href=\"http://www.bncatalo") ? "valid" : "invalid";
}

/*********************************************
 * TEST #5: Valid Wikilink Basic Check: invalid
 * an illegal character
 ********************************************/
const string valid_wikilink_test5() {
    return valid_wikilink(pre + "hello#" + suf) ? "valid" : "invalid";
}

/*********************************************
 * TEST #6: Valid Wikilink Basic Check: invalid
 * other illegal character
 ********************************************/
const string valid_wikilink_test6() {
    return valid_wikilink(pre + "hello:" + suf) ? "valid" : "invalid";
}

/*********************************************
 * TEST #7: Valid Wikilink Basic Check: invalid
 * both illegal characters
 ********************************************/
const string valid_wikilink_test7() {
    return valid_wikilink(pre + "hell&o:" + suf) ? "valid" : "invalid";
}


/*********************************************
 * main — provided code, not necessary to edit!
 * This is provided code that tests your valid_wikilink function
 * and, if those tests pass, your entire findWikiLinks function.
 * This is the CLI (command line interface) for this script.
 ********************************************/
int main(int argc, char *argv[]) {
    // improper use check:
    if (argc < 2) {
        std::cout << "Please specify a exercise number." << std::endl;
        return 1;
    }
    // parse exercise number argument from string to int.
    int exerciseNum = std::stoi(argv[1]);

    vector<std::function<const string()>> tests = { 
        valid_wikilink_test1,
        valid_wikilink_test2,
        valid_wikilink_test3,
        valid_wikilink_test4,
        valid_wikilink_test5,
        valid_wikilink_test6,
        valid_wikilink_test7
    };
    if (exerciseNum > 0 && exerciseNum < 8) {
        cout << tests[exerciseNum]() << endl;
    }
    
    return 0;
}
