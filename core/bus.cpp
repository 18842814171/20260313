#include<vector>
#include<cstdint>
class Message{
public:
	uint32_t src;//source device id
	uint32_t dst;//destination device id
	uint32_t addr;//address
	uint32_t data;
	uint32_t type;
};
enum MsgType{
	MSG_FETCH,//fetch inst
	MSG_READ,//read data
	MSG_WRITE,//write data
	MSG_RETURN //return
};

// cpu read from mem
// type=MSG_READ;
// addr=0x80000000
// mem to cpu
// type = MSG_RETURN
// data = 0x12345678;
# include<cstdio>
# include<queue>
# include<vector>
using namespace std;
class Device {
	public:

		queue<Message> in_queue;
		queue<Message> out_queue;


};
class Bus{
	// collect msg from out_queues
	// send to destination devices
	vector<Device*> devices;
	void route(){
	for (auto dev:devices){
	while (!dev->out_queue.empty())	{
		Message msg = dev->out_queue.front();
		dev->out_queue.pop();
	devices[msg.dst]->in_queue.push(msg);
	}
	}
	}
};

