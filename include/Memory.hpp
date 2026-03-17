#ifndef MEMORY_HPP
#define MEMORY_HPP
#include<cstdint>
#include<vector>
#define MEM_ID 001
/*class Memory:public Device{
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
};*/

class Memory{
	private:
		static const uint32_t MEM_SIZE = 1024;
		uint32_t mem[MEM_SIZE];
	public:
		Memory();
		uint32_t read(uint32_t addr);
		void write(uint32_t addr, uint32_t data);

};


#endif