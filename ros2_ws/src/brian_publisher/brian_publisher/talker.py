import rclpy
from rclpy.node import Node
from std_msgs.msg import String

class MyTalker(Node):
    def __init__(self):
        super().__init__('my_talker')
        self.pub = self.create_publisher(String, 'my_topic', 10)
        self.timer = self.create_timer(1.0, self.publish)
        self.count = 0

    def publish(self):
        msg = String()
        msg.data = f'Hello from Brian: {self.count}'  # replace {your_name} with your actual name
        self.pub.publish(msg)
        self.get_logger().info(f'Publishing: {msg.data}')
        self.count += 1

def main(args=None):
    rclpy.init(args=args)
    node = MyTalker()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()