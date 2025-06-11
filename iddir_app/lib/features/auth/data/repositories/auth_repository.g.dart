// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'6c8090e46ed60c0d51ad93471152f37f7aa9bae7';

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

abstract class _$AuthRepository
    extends BuildlessAutoDisposeNotifier<AuthRemoteDatasource> {
  late final Dio dio;

  AuthRemoteDatasource build(Dio dio);
}

/// See also [AuthRepository].
@ProviderFor(AuthRepository)
const authRepositoryProvider = AuthRepositoryFamily();

/// See also [AuthRepository].
class AuthRepositoryFamily extends Family<AuthRemoteDatasource> {
  /// See also [AuthRepository].
  const AuthRepositoryFamily();

  /// See also [AuthRepository].
  AuthRepositoryProvider call(Dio dio) {
    return AuthRepositoryProvider(dio);
  }

  @override
  AuthRepositoryProvider getProviderOverride(
    covariant AuthRepositoryProvider provider,
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
  String? get name => r'authRepositoryProvider';
}

/// See also [AuthRepository].
class AuthRepositoryProvider
    extends
        AutoDisposeNotifierProviderImpl<AuthRepository, AuthRemoteDatasource> {
  /// See also [AuthRepository].
  AuthRepositoryProvider(Dio dio)
    : this._internal(
        () => AuthRepository()..dio = dio,
        from: authRepositoryProvider,
        name: r'authRepositoryProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$authRepositoryHash,
        dependencies: AuthRepositoryFamily._dependencies,
        allTransitiveDependencies:
            AuthRepositoryFamily._allTransitiveDependencies,
        dio: dio,
      );

  AuthRepositoryProvider._internal(
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
  AuthRemoteDatasource runNotifierBuild(covariant AuthRepository notifier) {
    return notifier.build(dio);
  }

  @override
  Override overrideWith(AuthRepository Function() create) {
    return ProviderOverride(
      origin: this,
      override: AuthRepositoryProvider._internal(
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
  AutoDisposeNotifierProviderElement<AuthRepository, AuthRemoteDatasource>
  createElement() {
    return _AuthRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthRepositoryProvider && other.dio == dio;
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
mixin AuthRepositoryRef
    on AutoDisposeNotifierProviderRef<AuthRemoteDatasource> {
  /// The parameter `dio` of this provider.
  Dio get dio;
}

class _AuthRepositoryProviderElement
    extends
        AutoDisposeNotifierProviderElement<AuthRepository, AuthRemoteDatasource>
    with AuthRepositoryRef {
  _AuthRepositoryProviderElement(super.provider);

  @override
  Dio get dio => (origin as AuthRepositoryProvider).dio;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
