#include"bus.cpp"
#include<vector>
#define MEM_ID 001
class Memory:public Device{
public:
//	<vector>addr
	void process(){
	if(in_queue.empty())
		return;
	}
	Message msg = in_queue.front();
	in_queue.pop();
	if (msg.type==MSG_READ){
	Message resp;
	resp.src = MEM_ID;
	resp.type = MSG_RETURN;
	resp.data =memory[msg.addr];
	out_queue.push(resp);
	}
	}


};
