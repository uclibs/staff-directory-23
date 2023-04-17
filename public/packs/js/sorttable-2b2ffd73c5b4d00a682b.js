/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./app/javascript/packs/sorttable.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./app/javascript/packs/sorttable.js":
/*!*******************************************!*\
  !*** ./app/javascript/packs/sorttable.js ***!
  \*******************************************/
/*! no static exports found */
/***/ (function(module, exports) {

throw new Error("Module build failed (from ./node_modules/babel-loader/lib/index.js):\nSyntaxError: /Users/lisa/uclibs/staff-directory-23/app/javascript/packs/sorttable.js: Deleting local variable in strict mode. (74:6)\n\n  72 |         tfo.appendChild(sortbottomrows[i]);\n  73 |       }\n> 74 |       delete sortbottomrows;\n     |       ^\n  75 |     }\n  76 |     \n  77 |     // work through each column and calculate its type\n    at instantiate (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:64:32)\n    at constructor (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:364:12)\n    at Parser.raise (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:3253:19)\n    at Parser.parseMaybeUnary (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10802:16)\n    at Parser.parseMaybeUnaryOrPrivate (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10656:61)\n    at Parser.parseExprOps (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10661:23)\n    at Parser.parseMaybeConditional (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10638:23)\n    at Parser.parseMaybeAssign (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10599:21)\n    at Parser.parseExpressionBase (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10553:23)\n    at /Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10549:39\n    at Parser.allowInAnd (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:12239:16)\n    at Parser.parseExpression (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10549:17)\n    at Parser.parseStatementContent (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:12682:23)\n    at Parser.parseStatementLike (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:12548:17)\n    at Parser.parseStatementListItem (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:12528:17)\n    at Parser.parseBlockOrModuleBlockBody (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:13120:61)\n    at Parser.parseBlockBody (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:13113:10)\n    at Parser.parseBlock (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:13101:10)\n    at Parser.parseStatementContent (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:12635:21)\n    at Parser.parseStatementLike (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:12548:17)\n    at Parser.parseStatementOrSloppyAnnexBFunctionDeclaration (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:12538:17)\n    at Parser.parseIfStatement (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:12920:28)\n    at Parser.parseStatementContent (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:12579:21)\n    at Parser.parseStatementLike (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:12548:17)\n    at Parser.parseStatementListItem (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:12528:17)\n    at Parser.parseBlockOrModuleBlockBody (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:13120:61)\n    at Parser.parseBlockBody (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:13113:10)\n    at Parser.parseBlock (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:13101:10)\n    at Parser.parseFunctionBody (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:11911:24)\n    at Parser.parseFunctionBodyAndFinish (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:11897:10)\n    at /Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:13256:12\n    at Parser.withSmartMixTopicForbiddingContext (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:12221:14)\n    at Parser.parseFunction (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:13255:10)\n    at Parser.parseFunctionOrFunctionSent (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:11376:17)\n    at Parser.parseExprAtom (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:11149:21)\n    at Parser.parseExprSubscripts (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10859:23)\n    at Parser.parseUpdate (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10842:21)\n    at Parser.parseMaybeUnary (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10818:23)\n    at Parser.parseMaybeUnaryOrPrivate (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10656:61)\n    at Parser.parseExprOps (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10661:23)\n    at Parser.parseMaybeConditional (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10638:23)\n    at Parser.parseMaybeAssign (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10599:21)\n    at /Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10569:39\n    at Parser.allowInAnd (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:12244:12)\n    at Parser.parseMaybeAssignAllowIn (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:10569:17)\n    at Parser.parseObjectProperty (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:11760:83)\n    at Parser.parseObjPropValue (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:11787:100)\n    at Parser.parsePropertyDefinition (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:11721:17)\n    at Parser.parseObjectLike (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:11636:21)\n    at Parser.parseExprAtom (/Users/lisa/uclibs/staff-directory-23/node_modules/@babel/parser/lib/index.js:11146:23)");

/***/ })

/******/ });
//# sourceMappingURL=sorttable-2b2ffd73c5b4d00a682b.js.map