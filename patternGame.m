#import <Foundation/Foundation.h>

@interface GeneratorClass:NSObject
- (int) genPatternNum;
- (char) genPatternOp;
- (NSString *) genPatternExWithNum: (int) num andOp: (char) op;
@end

@implementation GeneratorClass
- (int) genPatternNum {
    const int RANDOM_RANGE = 10;

    return random() % RANDOM_RANGE + 2;
}

- (char) genPatternOp {
    const char OPS[] = {'+', '-', '*'};
    const int OPS_COUNT = 3;

    return OPS[random() % OPS_COUNT];
}

- (NSString *) genPatternExWithNum: (int) num andOp: (char) op {
    const int EX_COUNT = 5;
    const int START_RANGE = 20;
    int patternElem;
    NSString *res = @"";

    if (op == '+' || op == '*') {
        patternElem = 1;
    } else {
        patternElem = 80;
    }
    patternElem += random() % START_RANGE;

    int i;
    for (i = 0; i < EX_COUNT; i++) {
        res = [res stringByAppendingFormat:@"%d ", patternElem];
        
        if (op == '+') {
            patternElem += num;
        } else if (op == '*') {
            patternElem *= num;
        } else {
            patternElem -= num;
        }
    }

    return res;
}
@end

int main (int argc, const char * argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    const int TOTAL_ROUNDS = 3;
    int round;

    int numGuess;
    char opGuess;

    GeneratorClass *gen = [[GeneratorClass alloc]init];

    srandom(time(NULL));

    for (round = 0; round < TOTAL_ROUNDS; round++) {
        int num = [gen genPatternNum];
        int op = [gen genPatternOp];
        NSString *patternEx = [gen genPatternExWithNum: num
                                andOp: op];

        NSLog(@"%@", patternEx);

        NSLog(@"What is the operator? (+, -, *)");
        opGuess = getchar();

        NSLog(@"What is the number being used with the operator?");
        if (scanf(" %d", &numGuess) < 1) {
            NSLog(@"Integer scanf failed.");
        }
        getchar(); // refresh stdin for next scanf
        
        if (numGuess != num || opGuess != op) {
            NSLog(@"You lose :(");
            NSLog(@"The answer was %c %d", op, num);
            return 0;
        }
    }
    NSLog(@"You win!");

    [pool drain];
    return 0;
}

