#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <TwoPlusTwoIsFive.h>

class TwoPlusTwoIsFiveTest : public ::testing::Test {

};

TEST(TwoPlusTwoIsFiveTest, towPlusTwoIsFive){
  TwoPlusTwoIsFive wrong;

  EXPECT_EQ(5, wrong.returnTwoPlusTwo());

}
