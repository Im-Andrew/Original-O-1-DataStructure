package;

import haxe.Timer;
import SwapStack;

class Main {
    public static function main() {
        var ss:SwapStack<Int> = new SwapStack();
        
        trace("done testing validity.");

        var n = 0; // attempt to prevent compile optimizations
        var k = 5;
        var amt = 50000;
        var pushing = [0.0,0.0];
        var reading = [0.0,0.0];
        var popping = [0.0,0.0]; 


        // SwapStack
		for( j in 0...k ){
            var start = Timer.stamp();
            for( i in 0...amt ) ss.push(i);
            pushing[0] += (Timer.stamp() - start );
            start = Timer.stamp();
            for( i in 0...amt ){ n += ss.get(i) + 1; }
            reading[0] += (Timer.stamp() - start );
            start = Timer.stamp();
            for( i in 0...amt ) ss.pop(i);
            popping[0] += (Timer.stamp() - start );
            trace('$j');
            n = 0;
        }
        trace("finished swapstack");

        // Array
        var arr:Array<Int> = [];
		for( j in 0...k ){
            var start = Timer.stamp();
            for( i in 0...amt ) arr.push(i);
            pushing[1] += (Timer.stamp() - start );
            start = Timer.stamp();
            for( i in 0...amt ){ n += arr[i] + 1; };
            reading[1] += (Timer.stamp() - start );
            start = Timer.stamp();
            for( i in 0...amt ) arr.splice(0,1);
            popping[1] += (Timer.stamp() - start );
            trace('$j');
            n += 0;
        }
        trace("finished reg.");


        trace("totals:");
        trace("swap pushing ms: " + pushing[0]*1000 );
        trace("swap read access ms: " + reading[0]*1000 );
        trace("swap popping ms: " + popping[0]*1000 );

        trace("reg pushing ms: " + pushing[1]*1000 );
        trace("reg read access ms: " + reading[1]*1000 );
        trace("reg popping ms: " + popping[1]*1000 );

    }

    static function TestValidity( ss:SwapStack<Int> ){
     	ss.push( 0 );
     	ss.push( 1 );
     	ss.push( 2 );
     	ss.push( 3 );
        ss.push( 4 );
        trace( ss.toString() );

        ss.pop( 0 );
        ss.pop( 2 );
        trace( ss.toString() );
        ss.push( 2 );
        ss.push( 0 );
        trace( ss.toString() );
        ss.push(5);
        ss.push(6);
        trace( ss.toString() );
        
        ss.clear();
    }
}