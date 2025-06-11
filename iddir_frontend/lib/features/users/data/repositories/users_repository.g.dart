// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$usersRepositoryHash() => r'26047ab3b629948e1a698027826d07338d05b0f9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$UsersRepository
    extends BuildlessAutoDisposeNotifier<UsersRemoteDatasource> {
  late final Dio dio;

  UsersRemoteDatasource build(Dio dio);
}

/// See also [UsersRepository].
@ProviderFor(UsersRepository)
const usersRepositoryProvider = UsersRepositoryFamily();

/// See also [UsersRepository].
class UsersRepositoryFamily extends Family<UsersRemoteDatasource> {
  /// See also [UsersRepository].
  const UsersRepositoryFamily();

  /// See also [UsersRepository].
  UsersRepositoryProvider call(Dio dio) {
    return UsersRepositoryProvider(dio);
  }

  @override
  UsersRepositoryProvider getProviderOverride(
    covariant UsersRepositoryProvider provider,
  ) {
    return call(provider.dio);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'usersRepositoryProvider';
}

/// See also [UsersRepository].
class UsersRepositoryProvider
    extends
        AutoDisposeNotifierProviderImpl<
          UsersRepository,
          UsersRemoteDatasource
        > {
  /// See also [UsersRepository].
  UsersRepositoryProvider(Dio dio)
    : this._internal(
        () => UsersRepository()..dio = dio,
        from: usersRepositoryProvider,
        name: r'usersRepositoryProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$usersRepositoryHash,
        dependencies: UsersRepositoryFamily._dependencies,
        allTransitiveDependencies:
            UsersRepositoryFamily._allTransitiveDependencies,
        dio: dio,
      );

  UsersRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dio,
  }) : super.internal();

  final Dio dio;

  @override
  UsersRemoteDatasource runNotifierBuild(covariant UsersRepository notifier) {
    return notifier.build(dio);
  }

  @override
  Override overrideWith(UsersRepository Function() create) {
    return ProviderOverride(
      origin: this,
      override: UsersRepositoryProvider._internal(
        () => create()..dio = dio,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dio: dio,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<UsersRepository, UsersRemoteDatasource>
  createElement() {
    return _UsersRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UsersRepositoryProvider && other.dio == dio;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dio.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UsersRepositoryRef
    on AutoDisposeNotifierProviderRef<UsersRemoteDatasource> {
  /// The parameter `dio` of this provider.
  Dio get dio;
}

class _UsersRepositoryProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          UsersRepository,
          UsersRemoteDatasource
        >
    with UsersRepositoryRef {
  _UsersRepositoryProviderElement(super.provider);

  @override
  Dio get dio => (origin as UsersRepositoryProvider).dio;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
