package;

class SwapNode<T>{
    public var index = -1;		        /* Where the node actually is */
    public var ghostIndex = -1;         /* Where it has been shifted too */
    public var data: T; 		        /* Value this node stores. */
    public inline function new(data:T, index:Int ){
        this.index = index;
        this.data = data;
    }
}

/**
	A type of stack designed by Andrew Resto where push, pop, and access are all O(1).
	@Author: Andrew Resto
	@License: MIT LICENSE
*/
class SwapStack<T>{
    private var length = 0;						/* Total number of values stored */
    private var nodes:Array<SwapNode<T>> = [];	/* List holding values */
    public function new(){}
    
    public function clear(): Void{
        length = 0;
        for( node in nodes ) node.data = null;
    }
    
    public inline function get(index:Int):T{
        return nodes[index].data;
    }
    
    public inline function set(index:Int, val:T):T {
    	var node = nodes[index];
        if( node.index <= length ){
        	return (nodes[index].data = val);
        }else{
        	return nodes[index].data = nodes[nodes[index].ghostIndex].data = val;   
        }
    }
    
    /**
		Returns an index which will always point to this value.
	*/
    public function push( val:T ):Int{
        var newNode;
        if( length == nodes.length ){
            newNode = new SwapNode( val, length );
            nodes.push( newNode );
        }else{
            var ghostNode = nodes[length];
            if( ghostNode.data == null ){
                newNode = nodes[length];
                newNode.data = val;
            } else {
                newNode = nodes[ ghostNode.ghostIndex ];
                newNode.data = val;
            }
        }
		length ++;
        return newNode.index;
    }
    
    public function concat( arr: Array<T> ){
        for( v in arr ){
            push( v );    
        }
    }
    
    /**
		Removes the value stored at this index.
	*/
    public function pop( index: Int ){
        if( index == length ){
            nodes[length].data = null;
        } else if( index > length ){
            shiftHead( nodes[index].ghostIndex );
            nodes[index].data = null;
        } else {
            shiftHead( index );
        }
        length --;
    }
    
    private inline function shiftHead( to:Int ){
        var endPos = length -1; 
        if( endPos == to ){
            nodes[to].data = null;
        } else {
            var head = nodes[endPos];
            if( head.index != endPos ){ nodes[endPos].data = null; }
            head.ghostIndex = to;
            nodes[to].data = head.data;
            nodes[to].index = head.index;
            nodes[to].ghostIndex = to;
        }
    }
    
    public function toString():String{
      	var str:String = "";
        for( i in 0...length ){
		    str += nodes[i].data + ',';
        }
	    return str;
    }

    public function toDebugString():String{
        var str:String = "";
        for( i in 0...nodes.length ){
            if( nodes[i] == null ){
            	str += 'null,';
            	continue;
            }
	        str += nodes[i].data + ',';
        }
	    return str;
    }
}