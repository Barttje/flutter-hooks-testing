import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hooks Testing Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Hooks Testing Example'),
          ),
          body: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[UseAnimationExample()],
      ),
    );
  }
}

class UseStateExample extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
    return Row(
      children: [
        Text(
          counter.value.toString(),
          textDirection: TextDirection.ltr,
        ),
        RaisedButton(
            child: Icon(Icons.add),
            onPressed: () {
              counter.value++;
            })
      ],
    );
  }
}

class UseValueChangedExample extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
    final changedCounter = useState(0);
    useValueChanged(
        counter.value,
        (oldValue, oldResult) =>
            {changedCounter.value = changedCounter.value + 2});
    return Row(
      children: [
        Text(
          changedCounter.value.toString(),
        ),
        RaisedButton(
            child: Icon(Icons.add),
            onPressed: () {
              counter.value++;
            })
      ],
    );
  }
}

class UseEffectOnceExample extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
    useEffect(() {
      counter.value++;
    }, const []);
    return Row(
      children: [
        Text(
          counter.value.toString(),
        ),
        RaisedButton(
            child: Icon(Icons.add),
            onPressed: () {
              counter.value++;
            })
      ],
    );
  }
}

class UseEffectValueChangedExample extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
    useEffect(() {
      counter.value++;
    }, [counter.value]);
    return Row(
      children: [
        Text(
          counter.value.toString(),
        ),
        RaisedButton(
            child: Icon(Icons.add),
            onPressed: () {
              counter.value++;
            })
      ],
    );
  }
}

class UseEffectEachBuildExample extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
    useEffect(() {
      counter.value++;
    });
    return Row(
      children: [
        Text(
          counter.value.toString(),
        ),
        RaisedButton(
            child: Icon(Icons.add),
            onPressed: () {
              counter.value++;
            })
      ],
    );
  }
}

class UseAnimationExample extends HookWidget {
  final Duration duration = const Duration(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    final _controller = useAnimationController(duration: duration);
    _controller.forward();
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(child: Text(_controller.value.toString()));
        });
  }
}
