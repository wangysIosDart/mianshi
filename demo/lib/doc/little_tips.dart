///3种隐藏方式
///1、Visibility 隐藏/可见，能保存组件的状态；Offstage不能保存组件的状态，组件重新加载。
///2、当Offstage不可见（true）的时候，如果child有动画等，需要手动停掉，Offstage并不会停掉动画等操作。
///3、Offstage隐藏时不占空间，Visibility可以设置隐藏时占据空间也可以不占据空间，默认不隐藏时不占据空间

// 原来
///text != null ? Text(text) : const Container()

// 后来
///text != null ? Text(text) : const SizedBox()

// 现在
///text != null ? Text(text) : nil