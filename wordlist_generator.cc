#include "combination.hpp"
#include <boost/assign.hpp>
#include <iostream>
#include <vector>
#include <algorithm>
#include <boost/range/adaptors.hpp>
#include <boost/range/algorithm.hpp>
#include <boost/lexical_cast.hpp>
#include <string.h>
#include <boost/lambda/lambda.hpp>
using namespace boost::assign;

int main(int argc,char *argv[]){
	std::ios_base::sync_with_stdio(false);
	if (argc<4){
		return 1;
	}
	int min=boost::lexical_cast<int>(argv[1]);
	int max=boost::lexical_cast<int>(argv[2]);
	int len = strlen(argv[3]);
	char const * chars = argv[3];
	for (int r = min ;r <= max ;r++){
		std::vector<int> pat(r,0);
		auto fp=boost::lambda::ret<const char>(*(chars + boost::lambda::_1));
		do{
			boost::copy(pat|boost::adaptors::transformed(fp),std::ostreambuf_iterator<char>(std::cout));
			std::cout << "\n";
		}while(boost::next_mapping(pat.begin(),pat.end(),0,len));
	}
	return 0;
}
